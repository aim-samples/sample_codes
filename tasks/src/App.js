import { useState } from "react";
import './App.css';
import Form from './components/Form';
import TasksList from './components/TasksList';
import { AppHeader, Column } from "./other_components/Layout";


function App() {
  const [tasks1, setTask] = useState([]);

  const addTask1 = _task => setTask(_tasks => [..._tasks, _task]);

  const deleteTask = _index => {
    var temp = [...tasks1];
    temp.splice(_index, 1);
    setTask(temp);
  }

  return (
    <Column className='App'>
      <AppHeader title='Task manager' />
      <Form clickEvent={addTask1} />
      <TasksList tasks={tasks1} deleteCallback={deleteTask} />
    </Column>
  );
}

export default App;