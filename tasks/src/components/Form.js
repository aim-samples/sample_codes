import { useState } from "react";

import './Form.css'
import TitleBar from "../other_components/TitleBar";

function Form(props) {
  const [task, setTask] = useState("");

  const update = (value) => setTask(value);

  const add = (event) => {
    event.preventDefault();
    if (task !== "") {
      props.clickEvent(task);
      update("");
    }
  }

  return (
    <div className="FormContainer">
      <TitleBar title='Add Task'/>
      <hr/>
      <form onSubmit={add}>
        <input className="task" value={task} onChange={(e) => update(e.target.value)} placeholder='New task' />
        <input className="submit" type='submit' value='Add' onClick={add} />
      </form>
    </div>
  );
}

export default Form;