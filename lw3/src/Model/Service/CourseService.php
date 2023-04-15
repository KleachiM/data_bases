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
//TODO: убрать materialrepository
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
            $this->materialRepository->addMaterial($course);
        });
    }
}