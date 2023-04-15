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
//TODO: исправить внешние ключи
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
        $this->connection->execute("SET FOREIGN_KEY_CHECKS=0");
        foreach ($modulesToAdd as $module)
        {
            $str = '(' .implode(', ', $module) .')';
            $query = "INSERT INTO `wiki_backend`.course_material (module_id, course_id, is_required) VALUES " . $str;
            $this->connection->execute($query);
        }
        $this->connection->execute("SET FOREIGN_KEY_CHECKS=1");
    }

    public static function getStringFromArray(array $arr): string
    {
        $str = "";
        foreach ($arr as $item)
        {
            $str .= '(';
            $str .= implode(', ', $item);
            $str .= '), ';
        }
        $str = substr($str,0, -2);
        return $str;
    }
}