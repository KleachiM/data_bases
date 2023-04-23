<?php
declare(strict_types=1);

namespace App\Model\Service;

use App\Common\Database\Synchronization;
use App\Database\CourseRepository;
use App\Model\Course;
use App\Model\Data\SaveCourseParams;

class CourseService
{
    private Synchronization $synchronization;
    private CourseRepository $courseRepository;

    public function __construct(Synchronization $synchronization, CourseRepository $courseRepository)
    {
        $this->synchronization = $synchronization;
        $this->courseRepository = $courseRepository;
    }

    public function saveCourse(SaveCourseParams $params)
    {
        return $this->synchronization->doWithTransaction(function () use ($params)
        {
            $course = new Course(
                $params->getCourseId(),
                $params->getModuleIds(),
                $params->getRequiredModuleIds(),
                new \DateTimeImmutable(),
                null
            );
            $this->courseRepository->addCourse($course);
            $this->courseRepository->addMaterial($course);
        });
    }

    public function deleteCourse(string $uuid)
    {
        $this->courseRepository->deleteCourse($uuid);
    }
}