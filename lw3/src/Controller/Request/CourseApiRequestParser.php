<?php
declare(strict_types=1);

namespace App\Controller\Request;

use App\Model\Data\SaveCourseParams;

class CourseApiRequestParser
{
    private const MAX_COURSE_LENGTH = 36;
    private const MAX_MODULE_LENGTH = 36;
    public static function parseSaveCourseParams(array $parameters): SaveCourseParams
    {
        return new SaveCourseParams(
            self::parseString($parameters, 'courseId', self::MAX_COURSE_LENGTH),
            self::parseStringArray($parameters, 'moduleIds', self::MAX_MODULE_LENGTH),
            self::parseStringArray($parameters, 'requiredModuleIds', self::MAX_MODULE_LENGTH)
        );
    }

    public static function parseString(array $parameters, string $name, ?int $maxLength = null): string
    {
        $value = $parameters[$name] ?? null;
        if (!is_string($value))
        {
            throw new RequestValidationException([$name => 'Invalid string value']);
        }
        if ($maxLength !== null && mb_strlen($value) > $maxLength)
        {
            throw new RequestValidationException([$name => "String value too long (exceeds $maxLength characters)"]);
        }
        return $value;
    }

    public static function parseStringArray(array $parameters, string $name, ?int $maxLength = null): array
    {
        $values = self::parseArray($parameters, $name);
        foreach ($values as $index => $value)
        {
            if (!is_string($value))
            {
                throw new RequestValidationException([$name => "Invalid string value at index $index"]);
            }
            if ($maxLength !== null && mb_strlen($value) > $maxLength)
            {
                throw new RequestValidationException([$name => "String value too long (exceeds $maxLength characters) at index $index"]);
            }
        }
        return $values;
    }

    public static function parseArray(array $parameters, string $name): array
    {
        $values = $parameters[$name] ?? null;
        if (!is_array($values))
        {
            throw new RequestValidationException([$name => 'Not an array']);
        }
        return $values;
    }
}