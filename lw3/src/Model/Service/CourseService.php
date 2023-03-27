<?php
declare(strict_types=1);

namespace App\Model\Service;

use App\Common\Database\Synchronization;
use App\Database\CourseRepository;
use App\Model\Course;
use App\Model\Data\SaveCourseParams;
use App\Model\Exception\CourseAlreadyExistsException;

class CourseService
{
    private Synchronization $synchronization;
    private CourseRepository $courseRepository;

    public function saveCourse(SaveCourseParams $params)
    {
        if ($this->courseRepository->isAlreadyExist($params->getCourseId()))
        {
            throw new CourseAlreadyExistsException("Course {$params->getCourseId()} already exist!");
        }

        return $this->synchronization->doWithTransaction(function () use ($params)
        {
            $course = new Course(
                $params->getCourseId(),
                $params->getModuleIds(),
                $params->getRequiredModuleIds(),
                new \DateTimeImmutable(),
                null
            );
            return $this->courseRepository->createCourse($course);
        });
    }
}