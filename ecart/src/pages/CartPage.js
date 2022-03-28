import { useContext } from "react";
import { ProductWithDelete } from "../components/Product";
import TitleBar from "../components/Titlebar";
import SubTitlebar from "../components/SubTitlebar";
import { cartContext } from "../constants/contexts";

function CartPage() {
    const { cartItems, setCartItems } = useContext(cartContext);
    const productsListStyle = {
        maxWidth: 600,
        margin: 'auto',
    };
    const deleteItem = (index) => {
        setCartItems(items => {
            var _cartItems = [...items];
            _cartItems.splice(index, 1);
            return _cartItems;
        });
    };
    return <div style={productsListStyle}>
        <TitleBar title='Cart' />

        {cartItems.length <= 0 && <SubTitlebar title='Your cart is empty!' />}

        {cartItems.map((product, index) =>
            <ProductWithDelete key={index} product={product} onDelete={() => deleteItem(index)} />
        )}
    </div>;
}
export default CartPage;