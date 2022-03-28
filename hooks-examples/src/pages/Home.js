import { Link, Outlet } from "react-router-dom";
import './Home.css';

const links = [
    { to: '/', title: 'useState', isActive: true },
    { to: '/use_effect', title: 'useEffect', isActive: false },
];

const Home = () => {
    return (<>
        <nav>
            <ul>
                {
                    links.map((link, index) =>
                        <li key={index}>
                            <Link to={link.to} className={link.isActive ? 'active' : ''}>{link.title}</Link>
                        </li>
                    )
                }
                {/* <li><Link className="active" to='/'>useState</Link></li>
                <li><Link to='/use_effect'>useEffect</Link></li> */}
            </ul>
        </nav>
        <Outlet />
    </>);
}

export default Home;