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
            self::parseStringUuid($parameters, 'courseId', self::MAX_COURSE_LENGTH),
            self::parseStringUuidsArray($parameters, 'moduleIds', self::MAX_MODULE_LENGTH),
            self::parseStringUuidsArray($parameters, 'requiredModuleIds', self::MAX_MODULE_LENGTH)
        );
    }

    public static function parseStringUuid(array $parameters, string $name, ?int $maxLength = null): string
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
        if (!self::isValidUuid($value))
        {
            throw new RequestValidationException([$name => "Not valid uuid"]);
        }
        return $value;
    }

    public static function parseStringUuidsArray(array $parameters, string $name, ?int $maxLength = null): array
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
            if (!self::isValidUuid($value))
            {
                throw new RequestValidationException([$name => "Not valid uuid"]);
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

    public static function isValidUuid( $uuid ) {
        if (preg_match('/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/', $uuid) !== 1)
        {
            return false;
        }
        return true;
    }
}