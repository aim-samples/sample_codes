import styles from '../css.modules/titlebar.module.css';

export default function TitleBar({ title, style }) {
    return <h4 className={styles.titlebar} >{title}</h4>;
}
