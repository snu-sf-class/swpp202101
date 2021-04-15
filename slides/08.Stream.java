import java.io.*;

class LowerCaseInputStream extends FilterInputStream {
    public LowerCaseInputStream(InputStream in) {
	super(in);
    }

    public int read() throws IOException {
	int c = super.read();
	return (c == -1 ? c : Character.toLowerCase((char)c));
    }
    
    public int read(byte[] b, int offset, int len) throws IOException {
	int rlen = super.read(b, offset, len);
	for (int i = offset; i < offset + rlen; i++) {
	    b[i] = (byte)Character.toLowerCase((char)b[i]);
	}
	return rlen;
    }
}

class Main {
    public static void main(String[] args) throws IOException {
	int c;

	try {
	    InputStream in =
		new LowerCaseInputStream(
		    new BufferedInputStream(
		        new FileInputStream("08.Stream.txt")));
					
	    while ((c = in.read()) >= 0) {
		System.out.print((char)c);
	    }

	    in.close();
	} catch (IOException e) {
	    e.printStackTrace();
	}
    }
}

