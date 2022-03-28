import { useState } from 'react';
import './App.css';
import { AppHeader, Button, Column, Wrap } from './Layout';
import buttonStyle from './buttons.module.css';

const buttonValues = [
  // '','x!', '|x|', 'AC',
  '√', 'X²', 'X^', '%',
  'sin', 'cos', 'tan', 'CE',
  '7', '8', '9', '/',
  '4', '5', '6', '*',
  '1', '2', '3', '-',
  '.', '0', '=', '+'
];

function App() {
  const [calc, setCalc] = useState({
    sign: '',
    num: '',
    res: '0',
  });



  const numClickHandler = (e) => {
    const value = e.target.innerHTML;
    if (calc.res.length < 16)
      setCalc({
        ...calc,
        res: calc.res === 0 || calc.res === '0' ? value : calc.res + value,
      });
  }
  const pointClickHandler = (e) => {
    const value = e.target.innerHTML;
    setCalc({
      ...calc,
      res: calc.res + value
    });
  }
  function calculate(num1, num2, sign) {
    return Number(
      sign === '+' ? (Number(num1) + Number(num2)) :
        sign === '-' ? (Number(num1) - Number(num2)) :
          sign === '*' ? (Number(num1) * Number(num2)) :
            sign === '/' ? (Number(num1) / Number(num2)) :
              sign === '^' ? (Number(num1) ** Number(num2)) :
                calc.res
    ).toString();
  }
  const signClickHandler = (e) => {
    const value = e.target.innerHTML;
    setCalc({
      ...calc,
      num: calculate(calc.num, calc.res, calc.sign),
      // num: calc.res
      sign: value,
      res: '0'
    });
  }
  const clearClickHandler = (e) => {
    setCalc({
      ...calc,
      sign: calc.res !== '0' ? calc.sign : '',
      num: calc.res === '0' ? '' : calc.num,
      res: calc.res.length > 1 ? calc.res.slice(0, calc.res.length - 1) : '0'
    });
  }
  const equalsClickHandler = (e) => {
    setCalc({
      ...calc,
      res: calculate(calc.num, calc.res, calc.sign),
      sign: '',
      num: '',
    });
  }

  const sqrtClickHandler = (e) => {
    setCalc({
      ...calc,
      num: calc.res,
      sign: '√',
      res: Math.sqrt(calc.res),
    });
  }
  const squareClickHandler = (e) => {
    setCalc({
      ...calc,
      num: calc.res,
      sign: '^2',
      res: Number(calc.res) ** 2,
    });
  }
  const powerClickHandler = (e) => {
    setCalc({
      ...calc,
      num: calc.res,
      sign: '^',
      res: '0',
    });
  }
  const percentClickHandler = (e) => {
    setCalc({
      ...calc,
      num: calc.res,
      sign: '%',
      res: Number(calc.res) / 100,
    });
  }

  // const sinClickHandler = (e) => {
  //   setCalc({
  //     ...calc,
  //     num: calc.res,
  //     sign: 'sin',
  //     res: Math.sin(Number(calc.res)),
  //   });
  // }
  // const cosineClickHandler = (e) => {
  //   setCalc({
  //     ...calc,
  //     num: calc.res,
  //     sign: 'cos',
  //     res: Math.cos(Number(calc.res)),
  //   });
  // }
  // const tanClickHandler = (e) => {
  //   setCalc({
  //     ...calc,
  //     num: calc.res,
  //     sign: 'tan',
  //     res: Math.tan(Number(calc.res)),
  //   });
  // }
  const trignometricClickHandler = (e) => {
    const value = e.target.innerHTML;
    setCalc({
      ...calc,
      num: calc.res,
      sign: value,
      res: value === 'sin' ? Math.sin(Number(calc.res)) :
        value === 'cos' ? Math.cos(Number(calc.res)) :
          value === 'tan' ? Math.tan(Number(calc.res)) : 0,
    });
  }



  return (
    <Column className='calculator'>

      <AppHeader title='Calculator' />

      <Column className='display'>
        <h3>{
          calc.sign === '√'
            ? (calc.sign + calc.num)
            : ['sin', 'cos', 'tan'].includes(calc.sign)
              ? (calc.sign + '(' + calc.num + ')')
              : (calc.num + calc.sign)
        } </h3>
        <h2>{calc.res} </h2>
      </Column>

      <Wrap className='buttonpad'>
        {
          buttonValues.map((value, index) =>
            <Button
              key={index}
              className={
                value === '=' ? buttonStyle.equalsbutton :
                  ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'].includes(value) ? buttonStyle.numberbutton :
                    buttonStyle.functionbutton
              }
              handler={
                ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].includes(value) ? numClickHandler :
                  ['+', '-', '*', '/'].includes(value) ? signClickHandler :
                    ['sin', 'cos', 'tan'].includes(value) ? trignometricClickHandler :
                      // value === 'sin' ? sinClickHandler :
                      //   value === 'cos' ? cosineClickHandler :
                      //     value === 'tan' ? tanClickHandler :
                      value === '.' ? pointClickHandler :
                        value === 'CE' ? clearClickHandler :
                          value === '√' ? sqrtClickHandler :
                            value === 'X²' ? squareClickHandler :
                              value === 'X^' ? powerClickHandler :
                                value === '%' ? percentClickHandler :
                                  equalsClickHandler
              }
              value={value}
            />
          )
        }
      </Wrap>
    </Column>
  );
}

export default App;
