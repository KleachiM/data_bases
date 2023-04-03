<?php
declare(strict_types=1);

namespace App\Database;

use App\Common\Database\Connection;
use App\Model\Course;

class MaterialRepository
{
    private Connection $connection;
    public function __construct(Connection $connection)
    {
        $this->connection = $connection;
    }

    public function addMaterial(Course $course)
    {
        $courseId = $course->getCourseId();
        $modules = $course->getModuleIds();
        $requiredModules = $course->getRequiredModuleIds();
        $tmpArr = [];
        foreach ($modules as $module)
        {
            $is_required = (in_array($module, $requiredModules)) ? 1 : 0;
            array_push($tmpArr, $module, $courseId, $is_required);
        }
        $insParams = implode(", ", $tmpArr);
        $this->connection->execute("SET FOREIGN_KEY_CHECKS=0");
        $query = <<<SQL
            INSERT INTO course_material
                (module_id, course_id. is_required)
            VALUES 
                $insParams
            SQL;
        $this->connection->execute($query, [$insParams]);
        $this->connection->execute("SET FOREIGN_KEY_CHECKS=1");
//        $insParams;
    }

    public static function getCommaSeparatedList(string $item, int $count): string
    {
        $items = array_fill(0, $count, $item);
        return implode(', ', $items);
    }
}