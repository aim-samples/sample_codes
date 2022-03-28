import { useContext } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { cartContext } from '../constants/contexts';

import styles from '../css.modules/header.module.css';

function Header() {
    const location = useLocation();
    const { cartItems } = useContext(cartContext);

    const itemsCount = cartItems.length <= 0 ? '' : '(' + cartItems.length + ')';

    return <header className={styles.headerbar}>
        <Link className={styles.headerTitle} to='/'> E-Cart </Link>
        <nav>{
            location.pathname !== '/cart' &&
            <Link className={styles.headerNavLink} to='/cart'>Cart {itemsCount}</Link>
        }</nav>
    </header>;
}
export default Header;