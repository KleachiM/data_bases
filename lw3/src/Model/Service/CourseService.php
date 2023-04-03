<?php
declare(strict_types=1);

namespace App\Model\Service;

use App\Common\Database\Synchronization;
use App\Database\CourseRepository;
use App\Database\MaterialRepository;
use App\Model\Course;
use App\Model\Data\SaveCourseParams;
use App\Model\Exception\CourseAlreadyExistsException;

class CourseService
{
    private Synchronization $synchronization;
    private CourseRepository $courseRepository;
    private MaterialRepository $materialRepository;

    public function __construct(Synchronization $synchronization, CourseRepository $courseRepository, MaterialRepository $materialRepository)
    {
        $this->synchronization = $synchronization;
        $this->courseRepository = $courseRepository;
        $this->materialRepository = $materialRepository;
    }

    public function saveCourse(SaveCourseParams $params)
    {
//        if ($this->courseRepository->isAlreadyExist($params->getCourseId()))
//        {
//            throw new CourseAlreadyExistsException("Course {$params->getCourseId()} already exist!");
//        }

        return $this->synchronization->doWithTransaction(function () use ($params)
        {
            $course = new Course(
                $params->getCourseId(),
                $params->getModuleIds(),
                $params->getRequiredModuleIds(),
                new \DateTimeImmutable(),
                null
            );
            $this->materialRepository->addMaterial($course);
            $this->courseRepository->addCourse($course);
//            return $this->courseRepository->addCourse($course);
        });
    }
}