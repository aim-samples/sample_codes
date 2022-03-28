export function Row({children, style, className}){
    const _style = {
        display: 'flex',
        flexFlow: 'row',
        ...style,
    };
    return <div style={_style} className={className}> {children} </div>;
}
export function Column({children, style, className}){
    const _style = {
        display: 'flex',
        flexFlow: 'column',
        ...style,
    };
    return <div style={_style} className={className}> {children} </div>;
}
export function Wrap({children, style, className}){
    const _style = {
        display: 'flex',
        flexFlow: 'row wrap',
        ...style,
    };
    return <div style={_style} className={className}> {children} </div>;
}
