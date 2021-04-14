// Example for Inheritance
class Fruit {
    private String name;

    public Fruit() { name = ""; }
    public void setName(String name) { this.name = name; }
    public String getName() { return name; }
    public void print() {
	System.out.print("My name is " + getName() + "\n");
    }
}

class Apple extends Fruit {
    public Apple() { }
    public void print() {
	super.print();
	System.out.print("Moreover, I am an apple.\n");
    }
}

class Orange extends Fruit {
    public Orange() { }
    public void print() {
	super.print();
	System.out.print("Moreover, I am an orange.\n");
    }
}

class Main {
    static void printFruit(Fruit fruit) {
	fruit.setName("Gil");
	fruit.print();
    }
    
    public static void main(String[ ] args) {
	Apple apple = new Apple();
	Orange orange = new Orange();
	printFruit(apple);
	printFruit(orange);
    }
}
