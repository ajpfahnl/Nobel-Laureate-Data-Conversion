<?php
$servername = "localhost";
$username = "cs143";
$password = "";
$dbname = "class_db";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// get the id parameter from the request
$id = intval($_GET['id']);

// set the Content-Type header to JSON, 
// so that the client knows that we are returning JSON data
header('Content-Type: application/json');

$output = ["id" => strval($id)];

$familyName = "";
$givenName = "";
$gender = "";
$birth = "";

function check_n_push(&$arr_to, $arr_from, $value, $en=TRUE, $rename="") {
    $v = strval($arr_from[$value]);
    if ($rename != "") {
        $value = $rename;
    }
    if ($v != "") {
        if ($en) {
            $arr_to[$value] = ["en" => $v];
        } else {
            $arr_to[$value] = $v;
        }
    }
}

$sql = "SELECT * FROM People WHERE id={$id}";
$result = $conn->query($sql);

$person = FALSE;

if ($result->num_rows > 0) {
    $person = TRUE;
    $row = $result->fetch_assoc();
    check_n_push($output, $row, "givenName");
    check_n_push($output, $row, "familyName");
    check_n_push($output, $row, "gender", FALSE);
} else {
    $sql = "SELECT * FROM Organization WHERE id={$id}";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        check_n_push($output, $row, "orgName");
    }
}


$sql = "SELECT * FROM BirthFounded WHERE id={$id}";
$result = $conn->query($sql);
$birthFound = [];
if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    check_n_push($birthFound, $row, "birth_found", FALSE, "date");
    $place = [];
    check_n_push($place, $row, "city");
    check_n_push($place, $row, "country");
    if (count($place) > 0) {
        $birthFound["place"] = $place;
    }
}
if (count($birthFound) > 0) {
    if ($person == "yes") {
        $output["birth"] = $birthFound;
    } else {
        $output["founded"] = $birthFound;
    }
}

$nobelPrizes = [];
$sql = "SELECT * FROM NobelPrize WHERE id={$id}";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $np = [];
        check_n_push($np, $row, "awardYear", FALSE);
        check_n_push($np, $row, "category");
        check_n_push($np, $row, "sortOrder", FALSE);
        $npid = $row["npid"];
        $affiliations = [];
        $sql = "SELECT * FROM Affiliations WHERE npid={$npid}";
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $as = [];
                check_n_push($as, $row, "name");
                check_n_push($as, $row, "city");
                check_n_push($as, $row, "country");
                if (count($as) > 0) {
                    array_push($affiliations, $as);
                }
            }
        }
        if (count($affiliations) > 0) {
            $np["affiliations"] = $affiliations;
        }
        if (count($np) > 0) {
            array_push($nobelPrizes, $np);
        }
    }
}

if (count($nobelPrizes) > 0) {
    $output["nobelPrizes"] = $nobelPrizes;
}

/*
   Send the following fake JSON as the result
   {  "id": $id,
      "givenName": { "en": "A. Michael" },
      "familyName": { "en": "Spencer" },
      "affiliations": [ "UCLA", "White House" ]
   }
*/
// $output = (object) [
//     "id" => strval($id),
//     "givenName" => (object) [
//         "en" => $givenName
//     ],
//     "familyName" => (object) [
//         "en" => $familyName
//     ],
//     "affliations" => array(
//         "UCLA",
//         "White House"
//     )
// ];

$output = (object) $output;
echo json_encode($output, JSON_PRETTY_PRINT);

?>
