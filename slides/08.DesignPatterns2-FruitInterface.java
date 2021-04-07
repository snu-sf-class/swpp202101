interface FruitI {
    public void setName(String name);
    public String getName();
    public void print();
}

class Fruit {
    private String name;

    public Fruit() { name = ""; }
    public void setName(String name) { this.name = name; }
    public String getName() { return name; }
    public void print() {
	System.out.print("My name is " + getName() + "\n");
    }
}

class Apple implements FruitI {
    Fruit base;
    public Apple() { base = new Fruit(); }; // composition for code reuse
    /* boiler plate code */
    public void setName(String name) { base.setName(name); }
    public String getName() { return base.getName(); }
    
    public void print() {
	base.print();
	System.out.print("Moreover, I am an apple.\n");	
    }
}

class Orange implements FruitI {
    Fruit base;
    public Orange() { base = new Fruit(); }; // composition for code reuse
    public void setName(String name) { base.setName(name); }
    public String getName() { return base.getName(); }
    public void print() {
	base.print();
	System.out.print("Moreover, I am an orange.\n");	
    }
}

class Main {
    static void printFruit(FruitI fruit) {
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
