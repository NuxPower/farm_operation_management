<?php

namespace App\Http\Controllers;

use App\Models\PriceNegotiation;
use App\Models\RiceOrder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PriceNegotiationController extends Controller
{
    /**
     * Get all negotiations for an order
     */
    public function index(Request $request, RiceOrder $order)
    {
        $user = $request->user();

        if (!$this->canAccessOrder($user, $order)) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $negotiations = $order->negotiations()
            ->with('proposer:id,name')
            ->orderBy('created_at')
            ->get();

        return response()->json([
            'negotiations' => $negotiations,
        ]);
    }

    /**
     * Propose a new price negotiation
     */
    public function propose(Request $request, RiceOrder $order)
    {
        $user = $request->user();

        if (!$this->canAccessOrder($user, $order)) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        // Validate order is in a negotiable state
        if (!in_array($order->status, [RiceOrder::STATUS_PENDING, RiceOrder::STATUS_NEGOTIATING])) {
            return response()->json([
                'message' => 'Order is not in a negotiable state'
            ], 400);
        }

        $validator = Validator::make($request->all(), [
            'proposed_price' => 'required|numeric|min:0.01',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        // Supersede any pending negotiations
        $order->negotiations()
            ->where('status', PriceNegotiation::STATUS_PENDING)
            ->each(function ($negotiation) {
                $negotiation->supersede();
            });

        // Create new negotiation
        $negotiation = PriceNegotiation::create([
            'rice_order_id' => $order->id,
            'proposer_id' => $user->id,
            'proposed_price' => $request->proposed_price,
            'status' => PriceNegotiation::STATUS_PENDING,
        ]);

        // Update order status to negotiating
        if ($order->status !== RiceOrder::STATUS_NEGOTIATING) {
            $order->update(['status' => RiceOrder::STATUS_NEGOTIATING]);
        }

        $negotiation->load('proposer:id,name');

        return response()->json([
            'message' => 'Price proposal submitted successfully',
            'negotiation' => $negotiation,
        ], 201);
    }

    /**
     * Respond to a negotiation (accept, reject, or counter)
     */
    public function respond(Request $request, PriceNegotiation $negotiation)
    {
        $user = $request->user();

        if (!$negotiation->canBeRespondedBy($user)) {
            return response()->json(['message' => 'Unauthorized or negotiation is not pending'], 403);
        }

        $validator = Validator::make($request->all(), [
            'action' => 'required|in:accept,reject,counter',
            'counter_price' => 'required_if:action,counter|nullable|numeric|min:0.01',
            'message' => 'nullable|string|max:500',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        $order = $negotiation->order;

        if ($request->action === 'accept') {
            $negotiation->accept($request->message);

            return response()->json([
                'message' => 'Negotiation accepted. Price updated.',
                'negotiation' => $negotiation->fresh()->load('proposer:id,name'),
                'order' => $order->fresh(),
            ]);
        }

        if ($request->action === 'reject') {
            $negotiation->reject($request->message);

            return response()->json([
                'message' => 'Negotiation rejected.',
                'negotiation' => $negotiation->fresh()->load('proposer:id,name'),
            ]);
        }

        // Counter-proposal: reject current and create new
        if ($request->action === 'counter') {
            $negotiation->supersede();

            $counterProposal = PriceNegotiation::create([
                'rice_order_id' => $order->id,
                'proposer_id' => $user->id,
                'proposed_price' => $request->counter_price,
                'status' => PriceNegotiation::STATUS_PENDING,
            ]);

            $counterProposal->load('proposer:id,name');

            return response()->json([
                'message' => 'Counter-proposal submitted.',
                'negotiation' => $counterProposal,
            ], 201);
        }
    }

    /**
     * Check if user can access the order
     */
    protected function canAccessOrder(?object $user, RiceOrder $order): bool
    {
        if (!$user) {
            return false;
        }

        if ($order->buyer_id === $user->id) {
            return true;
        }

        $order->loadMissing('riceProduct');

        return $order->riceProduct && $order->riceProduct->farmer_id === $user->id;
    }
}
