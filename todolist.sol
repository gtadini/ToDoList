// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/**
 * @title Contrato ToDoList
 * @notice Contrato para organizar tareas
 * @author i3arba - 77 Innovation Labs
 */
contract ToDoList {
    struct Tarea {
        string description;
        bool completed;
        uint256 timestamp;
    }

    Tarea[] public s_tasks;  // Fixed: Use `Tarea` (not `Task`)

    event ToDoList_TaskCreated(Tarea task);
    event ToDoList_TaskCompleted(Tarea task);
    event ToDoList_TaskDeleted(string description, uint256 timestamp);  // Fixed: Added missing `timestamp` param

    function createTask(string memory _description) external {
        Tarea memory newTask = Tarea({  // Fixed: Use `Tarea` (not `Task`)
            description: _description,  // Fixed: Typo `_descripton` → `_description`
            completed: false,
            timestamp: block.timestamp
        });

        s_tasks.push(newTask);
        emit ToDoList_TaskCreated(newTask);
    }

    function getTask(uint256 _index) external view returns (Tarea memory) {  // Fixed: `Task` → `Tarea`
        return s_tasks[_index];  // Fixed: `s_task` → `s_tasks`
    }

    function completeTask(uint256 _index) external {
        s_tasks[_index].completed = true;  // Fixed: `s_tasks` (not `s_task`)
        emit ToDoList_TaskCompleted(s_tasks[_index]);
    }

    function deleteTask(string memory _description) external {
        uint256 arrayLength = s_tasks.length;
        for (uint256 i = 0; i < arrayLength; i++) {  // Fixed: `1 < arrayLength - 1` → `i < arrayLength`
            if (
                keccak256(bytes(s_tasks[i].description)) ==
                keccak256(bytes(_description))
            ) {
                s_tasks[i] = s_tasks[arrayLength - 1];
                s_tasks.pop();
                emit ToDoList_TaskDeleted(_description, block.timestamp);  // Fixed: Event name + added `timestamp`
                return;
            }
        }
    }
}