
function ListTile(props) {
    let tileStyle = {
        flex: '0 0 auto',
        lineHeight: '40px',
        display: 'flex',
        ...props.style,
    };
    let leadingStyle = {
        flex: props.leading === undefined ? 0 : '0 0 auto',
        minWidth: props.leading === undefined ? 0 : 50,
        textAlign: 'center',
    };
    let titleStyle = {
        paddingLeft: 10,
        minWidth: 0,

        flex: '1 1 auto',
        textOverflow: 'ellipsis',
        whiteSpace: 'nowrap',
        overflow: 'hidden',
    };
    let trailingStyle = {
        flex: props.trailing === undefined ? 0 : '0 0 auto',
    };
    return (
        <li key={props.key ?? 0} className={props.className} style={tileStyle}>
            <span style={leadingStyle} > {props.leading ?? ''} </span>
            <span style={titleStyle} > {props.title ?? ''} </span>
            <span style={trailingStyle} > {props.trailing ?? ''} </span>
        </li>
    );
}

export default ListTile;