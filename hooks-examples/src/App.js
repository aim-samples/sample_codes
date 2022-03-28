import {BrowserRouter, Routes, Route} from 'react-router-dom';
import UseEffect from './pages/UseEffect';
import UseState from './pages/UseState';
import Home from './pages/Home';
import NoPage from './pages/NoPage';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path='/' element={<Home />}>
          <Route index element={<UseState />} />
          <Route path='use_effect' element={<UseEffect />} />
          <Route path='*' element={<NoPage />}/>
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
