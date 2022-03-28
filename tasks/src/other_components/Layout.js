
export function Row({ children, style, className }) {
    const _style = {
        display: 'flex',
        flexFlow: 'row',
        ...style,
    };
    return <div style={_style} className={className}> {children} </div>;
}
export function Column({ children, style, className }) {
    const _style = {
        display: 'flex',
        flexFlow: 'column',
        ...style,
    };
    return <div style={_style} className={className}> {children} </div>;
}
export function Wrap({ children, style, className }) {
    const _style = {
        display: 'flex',
        flexFlow: 'row wrap',
        ...style,
    };
    return <div style={_style} className={className}> {children} </div>;
}
export function AppHeader({ title }) {
    const headerStyle = {
        flex: '0 0 50px',
        lineHeight: '50px',
        textAlign: 'center',
    };
    const titleStyle = {
        fontWeight: 500,
        fontSize: 22,
        color: '#FFFFFF'
    };
    return <header style={headerStyle}><h3 style={titleStyle}>{title}</h3> </header>;
}
export function Button({ value, handler, className, style }) {
    const _style = {
        padding: 10,
        border: 'none',
        height: 40,
        borderRadius: 4,
        flex: '1 1 calc(25% - 8px)',
        margin: 4,
        ...style
    }
    return <button style={_style} className={className} onClick={handler}>{value}</button>;
}