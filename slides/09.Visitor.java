//
// Car - Wheel, Engine, Body
// User - (1) Wheel -> ...
//        (2) Engine -> ...



interface CarElementVisitor {
    void visit(Wheel wheel);
    void visit(Engine engine);
}

interface CarElement {
    void accept(CarElementVisitor visitor); // CarElements have to provide accept().
}

class Wheel implements CarElement {
    private String name;

    public Wheel(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public void accept(CarElementVisitor visitor) {
	/* ... do something ... */
	
        visitor.visit(this);
    }
}

class Engine implements CarElement {
    /* ... some implementation ... */
    
    public void accept(CarElementVisitor visitor) {
	/* ... do something ... */
	
        visitor.visit(this);
    }
}

class Body implements CarElement {
    /* ... some implementation ... */

    public void accept(CarElementVisitor visitor) {
	/* do nothing */
    }
}

class Car implements CarElement{
    private Wheel[] wheels;
    private Engine engine;
    private Body body;

    public Car() {
	wheels = new Wheel[] {
	    new Wheel("front left"), new Wheel("front right"),
            new Wheel("back left") , new Wheel("back right") };
	engine = new Engine();
	body = new Body();
    }

    public void accept(CarElementVisitor visitor) {
	engine.accept(visitor);
	body.accept(visitor);
        for(Wheel element : this.wheels) {
            element.accept(visitor);
        }
    }
}

class CarElementPrintVisitor implements CarElementVisitor {
    public void visit(Wheel wheel) {
        System.out.println("Visiting "+ wheel.getName()
                            + " wheel");
    }

    public void visit(Engine engine) {
        System.out.println("Visiting engine");
    }
}

class CarElementDoVisitor implements CarElementVisitor {
    public void visit(Wheel wheel) {
        System.out.println("Kicking my "+ wheel.getName() + " wheel");
    }

    public void visit(Engine engine) {
        System.out.println("Starting my engine");
    }
}

class Main {
    static public void main(String[] args){
        Car car = new Car();
        car.accept(new CarElementPrintVisitor());
        car.accept(new CarElementDoVisitor());
    }
}
