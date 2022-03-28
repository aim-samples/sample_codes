import { Link } from 'react-router-dom';
import Product from '../components/Product';
import Products from '../constants/products';

function HomePage(){
    const productsListStyle = {
        maxWidth: 600,
        margin: 'auto',      
    };
    const linkStyle = {
        textDecoration: 'none',
    };
    return <div style={productsListStyle}>
        {Products.map((product, index) => 
            <Link key={index} style={linkStyle} to= {'/product/' + product.productId} >
                <Product product={product} />
            </Link>
        )}
    </div>;
}
export default HomePage;