// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract StudentGradingSystem{
    address public owner;

    // Struct to represent grades for an assignment or exam
    struct Grade {
        uint256 score;
        bool graded;
    }

     // Mapping to store grades for each student's assignment or exam
    mapping(address => mapping(string => Grade)) public grades;
    
    // Events to log grade submission and access
    event GradeSubmitted(address indexed student, string indexed assignment, uint256 score);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Function for teacher to submit grades
    function submitGrade(address student, string memory assignment, uint256 score) public onlyOwner {
        require(score >= 0 && score <= 100, "Invalid score");
        require(!grades[student][assignment].graded, "Grade already submitted");
        
        grades[student][assignment] = Grade(score, true);
        emit GradeSubmitted(student, assignment, score);
    }

    // Function for student to view their grades
    function viewGrade(string memory assignment) public view returns (uint256) {
        require(grades[msg.sender][assignment].graded, "Grade not available");
        
        Grade memory grade = grades[msg.sender][assignment];
        
        return grade.score;
    }
}
