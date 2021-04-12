interface UserI {
    public void print();
}

class User implements UserI {
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

class VIP implements UserI {
    private User user;
    private String account;

    public VIP(String name, String address, String account) {
	user = new User(name, address);
	this.account = account;
    }
    
    public void print() {
	user.print();
	System.out.println(account);
    }
}

class Main {
    static void printUser(UserI user) {
	user.print();
    }
    public static void main(String[ ] args) {
	User user = new User("sunghwan","SNU");
	VIP vip = new VIP("gil", "SNU", "1234");

	printUser(user);
	printUser(vip);
    }
}
