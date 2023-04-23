<?php
declare(strict_types=1);

namespace App\Controller\Request;

class UuidValidator
{
    public static function isValidUuid( $uuid ): bool
    {
        if (preg_match('/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/', $uuid) !== 1)
        {
            return false;
        }
        return true;
    }
}