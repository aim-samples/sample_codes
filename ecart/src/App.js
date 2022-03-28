import './App.css';
import { useState } from 'react';
import { cartContext } from './constants/contexts';
import { BrowserRouter, Route, Routes } from 'react-router-dom';

import HomePage from './pages/HomePage';
import ProductPage from './pages/ProductPage';
import CartPage from './pages/CartPage';
import Layout from './pages/Layout';

function App() {
  const [cartItems, setCartItems] = useState([]);
  return (
    <cartContext.Provider value={{ cartItems, setCartItems }}>
      <BrowserRouter>
        <Routes>
          <Route path='/' element={<Layout />}>
            <Route index element={< HomePage />} />
            <Route path='product/:id' element={<ProductPage />} />
            <Route path='cart' element={<CartPage />} />
          </Route>
        </Routes>
      </BrowserRouter>
    </cartContext.Provider>
  );
}

export default App;
