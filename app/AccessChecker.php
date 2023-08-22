<?php

class AccessChecker
{
    public function __construct(private readonly PDO $connection)
    {}

    public function checkAccess($username, $functionName): bool
    {
        $accessQuery = "SELECT COALESCE(ua.access_granted, ar.access_granted) AS access
                        FROM users u
                        LEFT JOIN access_rights ua ON u.id = ua.user_id
                        LEFT JOIN user_groups ug ON u.group_id = ug.id
                        LEFT JOIN access_rights ar ON ar.group_id = ug.id
                        LEFT JOIN module_functions mf ON mf.id = ua.function_id
                        WHERE u.username = :username
                        AND (mf.function_name = :functionName OR ua.function_id IS NULL)
                        LIMIT 1";

        $stmt = $this->connection->prepare($accessQuery);
        $stmt->execute([
            ':username' => $username,
            ':functionName' => $functionName
        ]);

        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        return ($result && $result['access'] === 1);
    }
}

