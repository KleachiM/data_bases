<?php
declare(strict_types=1);

namespace App\Controller;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;

class CourseApiController
{
    private const HTTP_STATUS_OK = 200;
    private const HTTP_STATUS_BAD_REQUEST = 400;

    public function saveCourse(ServerRequestInterface $request, ResponseInterface $response): ResponseInterface
    {

    }
}