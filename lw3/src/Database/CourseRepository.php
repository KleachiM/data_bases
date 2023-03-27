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

    public function isAlreadyExist(string $courseId): bool
    {
        $query = <<<SQL
            SELECT course_id FROM course
            SQL;
        $params = [$courseId];
        $stmt = $this->connection->execute($query, $params);
        if ($row = $stmt->fetch(\PDO::FETCH_ASSOC))
        {
            return true;
        }
        return false;
    }

    public function createCourse(Course $course)
    {
        $query = <<<SQL
            INSERT INTO course
                (courseId)
            VALUES
                (:courseId);
            INSERT INTO 
            SQL;
        $params = [
            ':courseId' => $course->getCourseId();
        ]
    }
}