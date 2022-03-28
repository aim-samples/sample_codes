import styles from '../css.modules/subtitlebar.module.css';

export default function TitleBar({title, style}) {
    return <p className={styles.subtitlebar} >{title}</p>;
}
