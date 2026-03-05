<?php

namespace App\Http\Requests\Labor;

use Illuminate\Foundation\Http\FormRequest;
use App\Rules\NoEmoji;

class StoreLaborerRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name' => ['required', 'string', 'max:255', new NoEmoji],
            'phone' => ['required', 'string', 'max:20', 'regex:/^(09|\+639)\d{9}$/', new NoEmoji],
            'email' => 'nullable|email|max:255',
            'address' => ['nullable', 'string', 'max:500', new NoEmoji],
            'skill_level' => 'required|string|in:beginner,intermediate,advanced,expert',
            'specialization' => ['nullable', 'string', 'max:255', new NoEmoji],
            'hourly_rate' => 'required|numeric|min:0',
            'status' => 'required|string|in:active,inactive,on_leave',
            'hire_date' => 'required|date',
            'emergency_contact' => ['nullable', 'string', 'max:255', new NoEmoji],
            'notes' => ['nullable', 'string', 'max:2000', new NoEmoji],
        ];
    }

    /**
     * Get custom messages for validator errors.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'name.required' => 'Laborer name is required.',
            'name.max' => 'Name cannot exceed 255 characters.',
            'phone.required' => 'Phone number is required.',
            'phone.max' => 'Phone number cannot exceed 20 characters.',
            'email.email' => 'Email must be a valid email address.',
            'email.max' => 'Email cannot exceed 255 characters.',
            'skill_level.required' => 'Skill level is required.',
            'skill_level.in' => 'Skill level must be one of: beginner, intermediate, advanced, expert.',
            'specialization.max' => 'Specialization cannot exceed 255 characters.',
            'hourly_rate.required' => 'Hourly rate is required.',
            'hourly_rate.numeric' => 'Hourly rate must be a number.',
            'hourly_rate.min' => 'Hourly rate must be greater than or equal to 0.',
            'status.required' => 'Status is required.',
            'status.in' => 'Status must be one of: active, inactive, on_leave.',
            'hire_date.required' => 'Hire date is required.',
            'hire_date.date' => 'Hire date must be a valid date.',
            'emergency_contact.max' => 'Emergency contact cannot exceed 255 characters.',
        ];
    }
}