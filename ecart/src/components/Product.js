import styles from '../css.modules/product.module.css';

function Product({ product }) {
    return <div className={styles.productbar}>
        <img className={styles.productbaricon} src={product.imagePath} alt='failed' />
        <div className={styles.productbardetails}>
            <h3>{product.name}</h3>
            <p>{product.extra}</p>
            <h4>₹{product.price}</h4>
        </div>
    </div>;
}

export function ProductWithDelete({ product, onDelete }) {
    return <div className={styles.productbar}>
        <img className={styles.productbaricon} src={product.imagePath} alt='failed' />
        <div className={styles.productbardetails}>
            <h3>{product.name}</h3>
            <p>{product.extra}</p>
            <h4>₹{product.price}</h4>
        </div>
        <button className={styles.productbardeletebutton} onClick={onDelete} >Remove</button>
    </div>;
}
export default Product;