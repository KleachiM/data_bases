<?php
declare(strict_types=1);

namespace App\Controller;

use App\Controller\Request\CourseApiRequestParser;
use App\Controller\Request\RequestValidationException;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;

class CourseApiController
{
    private const HTTP_STATUS_OK = 200;
    private const HTTP_STATUS_BAD_REQUEST = 400;

    public function saveCourse(ServerRequestInterface $request, ResponseInterface $response): ResponseInterface
    {
        try
        {
            $params = CourseApiRequestParser::parseSaveCourseParams((array)$request->getParsedBody());
        }
        catch (RequestValidationException $exception)
        {
            return $this->badRequest($response, $exception->getFieldErrors());
        }

//        courseId = ServiceProvider::getInstance()

    }

    private function success(ResponseInterface $response, array $responseData): ResponseInterface
    {
        return $this->withJson($response, $responseData)->withStatus(self::HTTP_STATUS_OK);
    }

    private function badRequest(ResponseInterface $response, array $errors): ResponseInterface
    {
        $responseData = ['errors' => $errors];
        return $this->withJson($response, $responseData)->withStatus(self::HTTP_STATUS_BAD_REQUEST);
    }

    private function withJson(ResponseInterface $response, array $responseData): ResponseInterface
    {
        try
        {
            $responseBytes = json_encode($responseData, JSON_THROW_ON_ERROR);
            $response->getBody()->write($responseBytes);
            return $response->withHeader('Content-Type', 'application/json');
        }
        catch (\JsonException $e)
        {
            throw new \RuntimeException($e->getMessage(), $e->getCode(), $e);
        }
    }
}