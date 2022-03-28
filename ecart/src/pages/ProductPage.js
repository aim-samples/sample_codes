import { useContext } from 'react';
import { useParams } from 'react-router-dom';
import { cartContext } from '../constants/contexts';
import Products from '../constants/products';
import './ProductPage.css';
import Titlebar from '../components/Titlebar';
import SubTitlebar from '../components/SubTitlebar';
function ProductPage() {
    const { setCartItems } = useContext(cartContext);
    const { id } = useParams();
    
    const product = Products.find(element => element.productId === Number(id));
    
    return (<div className='ProductPage'>
        <img alt='failed'
            src={'../' + Products.find(element => element.productId === Number(id)).imagePath} />
        <h3 className='name'>{product.name}</h3>
        <p className='extra'>{product.extra}</p>
        <h4 className='price'>₹{product.price}</h4>

        <button className='toCart' onClick={() => setCartItems(items => [...items, product])}>Add to cart</button>
        <button className='toBuy' onClick={() => { }}>Buy now</button>
        <hr />

        <Titlebar title='Product discription' />
        <SubTitlebar title={product.extra} />
        <hr />

        <Titlebar title='Reviews' />
        <SubTitlebar title='no reviews' />
        <hr />

        <Titlebar title='Similar products' />
        <SubTitlebar title='not found' />
    </div>);
}
export default ProductPage;