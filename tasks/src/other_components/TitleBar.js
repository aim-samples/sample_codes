import ListTile from "./ListTile";

function TitleBar(props) {
    const titleStyle = {
        color: '#212121',
    };
    const trailingStyle = {
        paddingRight: '20px',
    };
    return (
        <ListTile
            title={<h3 style={titleStyle}>{props.title}</h3>}
            trailing={<span style={trailingStyle}>{props.trailing}</span>}
        />
    );
}

export default TitleBar;