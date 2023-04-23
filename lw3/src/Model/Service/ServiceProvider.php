<?php
declare(strict_types=1);

namespace App\Model\Service;

use App\Common\Database\ConnectionProvider;
use App\Common\Database\Synchronization;
use App\Database\CourseRepository;
use App\Database\MaterialRepository;

final class ServiceProvider
{
    private ?CourseService $courseService = null;
    private ?CourseRepository $courseRepository = null;

    public static function getInstance(): self
    {
        static $instance = null;
        if ($instance === null)
        {
            $instance = new self();
        }
        return $instance;
    }

    public function getCourseService(): CourseService
    {
        if ($this->courseService === null)
        {
            $synchronization = new Synchronization(ConnectionProvider::getConnection());
            $this->courseService = new CourseService($synchronization, $this->getCourseRepository());
        }
        return $this->courseService;
    }

    private function getCourseRepository(): CourseRepository
    {
        if ($this->courseRepository === null)
        {
            $this->courseRepository = new CourseRepository(ConnectionProvider::getConnection());
        }
        return $this->courseRepository;
    }
}