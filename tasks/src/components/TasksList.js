import './TaskList.css';
import TitleBar from '../other_components/TitleBar';
import ListTile from '../other_components/ListTile';

function TasksList(props) {
    let tasks = () => props.tasks.map((task, index) => <>
        <ListTile
            key={index}
            className='TaskListItem'
            leading={<span style={{ width: '40px', padding: '10px' }} > {index + 1}</span>}
            title={task}
            trailing={<button className='button' onClick={() => deleteTask(index)}>Delete</button>} />
        <hr />
    </>);
    let noTasks = () => <div className='NoTaskUi'>
        <h3>No tasks found, please create one from above!</h3>
    </div>;
    let deleteTask = _index => props.deleteCallback(_index);
    return <div className="TaskListContainer">
        <TitleBar title='Available tasks' trailing={props.tasks.length} />
        <hr />
        {props.tasks.length > 0 ? <ul className="TaskList"> {tasks()} </ul> : noTasks()}
    </div>;

    // let tasks = () => props.tasks.map((task, index) => <>
    //     <ListTile
    //         key={index}
    //         className='TaskListItem'
    //         leading={<span style={{ width: '40px' }} > {index + 1}</span>}
    //         title={task}
    //         trailing={<button className='button' onClick={() => deleteTask(index)}>Delete</button>} />
    //     <hr />
    // </>);
    // let Tasks = () => <ul className="TaskList"> {tasks()} </ul>;
    // let NoTasks = () => <div className='NoTaskUi'>
    //     <h3>No tasks found, please create one from above!</h3>
    // </div>;
    // let deleteTask = _index => props.deleteCallback(_index);
    // return <div className="TaskListContainer">
    //     <TitleBar title='Available tasks' trailing={props.tasks.length} />
    //     <hr />
    //     {/* {props.tasks.length > 0 ? <ul className="TaskList"> {tasks()} </ul> : noTasks()} */}
    //     {props.tasks.length > 0 ? <Tasks /> : <NoTasks />}
    // </div>;
}

export default TasksList;