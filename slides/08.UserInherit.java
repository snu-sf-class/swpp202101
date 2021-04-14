class User {
    private String name;
    private String address;

    public User(String name, String address) {
	this.name = name;
	this.address = address;
    }

    public void print() {
	System.out.println(name);
	System.out.println(address);
    }
}

class VIP extends User {
    private String account;

    public VIP(String name, String address, String account) {
	super(name, address);
	this.account = account;
    }

    public void print() {
	super.print();
	System.out.println(account);
    }
}

class Main {
    static void printUser(User user) {
	user.print();
    }
    public static void main(String[ ] args) {
	User user = new User("sunghwan","SNU");
	VIP vip = new VIP("gil", "KAIST", "1234");

	printUser(user);
	printUser(vip);
    }
}

