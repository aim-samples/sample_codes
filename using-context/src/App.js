import {useContext, createContext, useState} from 'react';

const UserContext = createContext();
function Component1(){
  const [user, setUser] = useState("admi");
  const change = () => setUser( _old => _old === 'admi' ? "pakya": 'admi');
  
  return (
    <UserContext.Provider value={user}>
      <>
        <h2>Component1</h2>
        <button onClick={change}>Change</button>
        <hr />
        <Component2 />
      </>
    </UserContext.Provider>
  );

}
const Component2 = () => <Component3 />;

const Component3 = () => <Component4 />; 

const Component4 = () => <Component5 />;

function Component5(){
  const user = useContext(UserContext);
  return (
    <>
      <h2>Component5</h2>
      <h4>{user}</h4>
    </>
  );
}

export default Component1;
