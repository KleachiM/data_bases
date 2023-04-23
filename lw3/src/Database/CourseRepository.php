<?php
declare(strict_types=1);

namespace App\Database;

use App\Common\Database\Connection;
use App\Model\Course;
use http\Params;

class CourseRepository
{
    private Connection $connection;
    public function __construct(Connection $connection)
    {
        $this->connection = $connection;
    }

    public function addCourse(Course $course)
    {

        $query = <<<SQL
            INSERT INTO course
                (course_id)
            VALUES
                (:courseId);
            SQL;
        $params = [
            ':courseId' => $course->getCourseId()
        ];

        $this->connection->execute($query, $params);
    }

    public function addMaterial(Course $course)
    {
        $courseId = $course->getCourseId();
        $modules = $course->getModuleIds();
        $requiredModules = $course->getRequiredModuleIds();
        $modulesToAdd = [];
        foreach ($modules as $module)
        {
            $is_required = (in_array($module, $requiredModules)) ? 1 : 0;
            $tmpArr = array("'" .$module ."'", "'" .$courseId ."'", strval($is_required));
            $modulesToAdd[] = $tmpArr;
        }
        foreach ($modulesToAdd as $module)
        {
            $str = '(' .implode(', ', $module) .')';
            $query = "INSERT INTO `wiki_backend`.course_material (module_id, course_id, is_required) VALUES " . $str;
            $this->connection->execute($query);
        }
    }

    public function deleteCourse(string $uuid)
    {
        //TODO: доделать удаление курса
    }
}