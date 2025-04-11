<?php

declare(strict_types=1);

namespace App\MoonShine\Resources;

use App\Models\Department;
use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\UI\Components\Layout\Box;
use MoonShine\UI\Fields\ID;
use MoonShine\Contracts\UI\FieldContract;
use MoonShine\Contracts\UI\ComponentContract;
use MoonShine\UI\Fields\Text;

/**
 * @extends ModelResource<Department>
 */
class DepartmentResource extends ModelResource
{
    protected string $model = Department::class;

    protected string $title = 'Отделы';

    protected function indexFields(): iterable
    {
        return [
            ID::make()->sortable(),
            Text::make('Название', 'name'),
        ];
    }

    protected function formFields(): iterable
    {
        return [
            Box::make([
                ID::make(),
                Text::make('Название', 'name')
                    ->required(),
            ])
        ];
    }

    protected function detailFields(): iterable
    {
        return [
            ID::make(),
            Text::make('Название', 'name'),
        ];
    }

    protected function rules(mixed $item): array
    {
        return [
            'name' => 'required|string|max:255',
        ];
    }
} 