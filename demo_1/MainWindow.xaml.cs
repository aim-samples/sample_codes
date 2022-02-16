using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace demo_1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        Person newPerson = new Person();
        public MainWindow()
        {

            InitializeComponent();
            this.DataContext = newPerson;
            submit.Click += SubmitButton_Click;
        }

        private void SubmitButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show($"Hello {newPerson.Name} {newPerson.Age}");
        }
    }
    class Person
    {
        private string name;
        private string age;
        public string Name { get => name; set => name = value; }
        public string Age { get => age; set => age = value; }

    }
}
