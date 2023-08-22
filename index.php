<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'app/DatabaseConnection.php';
require_once 'app/AccessChecker.php';

function handle(): bool
{
    $dbConnection = new DatabaseConnection('db', 'access_rights', 'user', 'user');
    $conn = $dbConnection->getConnection();

    $accessChecker = new AccessChecker($conn);

    $username = "testuser";
    $functionName = "test_function";

    if ($accessChecker->checkAccess($username, $functionName)) {
        return true;
    }
    return false;

}
echo handle() ? 'Access granted' : 'Access denied';