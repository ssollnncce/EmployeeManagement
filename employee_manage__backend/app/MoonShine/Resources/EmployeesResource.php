<?php

declare(strict_types=1);

namespace App\MoonShine\Resources;

use Illuminate\Database\Eloquent\Model;
use App\Models\User;

use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\UI\Components\Layout\Box;
use MoonShine\UI\Fields\ID;
use MoonShine\Contracts\UI\FieldContract;
use MoonShine\Contracts\UI\ComponentContract;
use MoonShine\UI\Fields\Text;
use MoonShine\Laravel\Fields\Relationships\BelongsTo;
use MoonShine\UI\Fields\Select;
use MoonShine\UI\Fields\Password;
use App\Models\Department;
use MoonShine\Contracts\UI\ActionButtonContract;
use MoonShine\UI\Components\ActionButton;
/**
 * @extends ModelResource<User>
 */
class EmployeesResource extends ModelResource
{
    protected string $model = User::class;

    protected string $title = 'Сотрудники';
    
    /**
     * @return list<FieldContract>
     */
    protected function indexFields(): iterable
    {
        return [
            ID::make()->sortable(),
            Text::make('Имя', 'first_name'),
            Text::make('Фамилия', 'last_name'),
            Text::make('Отчество', 'patronymic'),
            Text::make('Email', 'email'),
            Text::make('Телефон', 'phone_number'),
            Text::make('Должность', 'position'),
            Text::make('Руководитель', 'manager.full_name')
                ->badge(),
            Text::make('Отдел', 'department_name.name')
                ->badge(),
            Text::make('Режим работы', 'work_mode')
                ->badge(),

        ];
    }

    /**
     * @return list<ComponentContract|FieldContract>
     */
    protected function formFields(): iterable
    {
        return [
            Box::make([
                ID::make(),
                Text::make('Имя', 'first_name')
                    ->required(),
                Text::make('Фамилия', 'last_name')
                    ->required(),
                Text::make('Отчество', 'patronymic')
                    ->required(),
                Text::make('Email', 'email')
                    ->required(),
                Text::make('Телефон', 'phone_number')
                    ->required(),
                Text::make('Должность', 'position')
                    ->required(),
                Select::make('Руководитель', 'manager_id')
                    ->nullable()
                    ->searchable()
                    ->options(User::all()->mapWithKeys(fn($manager) => [$manager->id => (string) "{$manager->first_name} {$manager->last_name} {$manager->patronymic}"])->toArray()),
                Select::make('Отдел', 'department')
                    ->nullable() 
                    ->searchable()
                    ->options(Department::query()->pluck('name', 'id')->toArray()),
                Select::make('Режим работы', 'work_mode')
                    ->options([
                        'office' => 'Офис',
                        'remote' => 'Удаленно'
                    ])
                    ->required(),
                Password::make('Пароль', 'password')
                    ->eye()
                    ->customAttributes(['autocomplete' => 'new-password'])
            ])
        ];
    }

    /**
     * @return list<FieldContract>
     */
    protected function detailFields(): iterable
    {
        return [
            Box::make([
                ID::make(),
                Text::make('Имя', 'first_name')
                    ->required(),
                Text::make('Фамилия', 'last_name')
                    ->required(),
                Text::make('Отчество', 'patronymic')
                    ->required(),
                Text::make('Email', 'email')
                    ->required(),
                Text::make('Телефон', 'phone_number')
                    ->required(),
                Text::make('Должность', 'position')
                    ->required(),
                Select::make('Руководитель', 'manager_id')
                    ->nullable()
                    ->searchable()
                    ->options(User::all()->mapWithKeys(fn($manager) => [$manager->id => (string) "{$manager->first_name} {$manager->last_name} {$manager->patronymic}"])->toArray()),
                Select::make('Отдел', 'department')
                    ->nullable() 
                    ->searchable()
                    ->options(Department::query()->pluck('name', 'id')->toArray()),
                Select::make('Режим работы', 'work_mode')
                    ->options([
                        'office' => 'Офис',
                        'remote' => 'Удаленно'
                    ])
                    ->required(),
                Password::make('Пароль', 'password')
                    ->eye()
            ])
        ];
    }

    /**
     * @param Employees $item
     *
     * @return array<string, string[]|string>
     * @see https://laravel.com/docs/validation#available-validation-rules
     */
    protected function rules(mixed $item): array
    {
        return [
            'first_name' => 'required|string|max:255',
            'last_name' => 'required|string|max:255',
            'patronymic' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email,' . ($item?->id ?? 'NULL'),
            'phone_number' => 'required|string|max:15',
            'position' => 'required|string|max:255',
            'manager_id' => 'nullable|exists:users,id',
            'department' => 'nullable|exists:departments,id',
            'work_mode' => 'required|in:office,remote',
            'password' => $item?->exists ? 'nullable|min:6' : 'required|min:6',
        ];
    }
}
