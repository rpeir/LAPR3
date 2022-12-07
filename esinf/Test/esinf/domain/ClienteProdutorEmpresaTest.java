package esinf.domain;

import domain.ClienteProdutorEmpresa;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ClienteProdutorEmpresaTest {

    public ClienteProdutorEmpresaTest() {
    }

    @BeforeEach
    public void setUp() {
    }

    @Test
    public void testValidateEmpresaID() {
        System.out.println("validateEmpresaID");
        String id = "123456789";
        String id2 = "E10";
        String id3 = "E10A";
        String id4 = "P10";
        boolean expResult = false;
        boolean expResult2 = true;
        boolean expResult3 = false;
        boolean expResult4 = false;
        boolean result = ClienteProdutorEmpresa.validateEmpresaID(id);
        boolean result2 = ClienteProdutorEmpresa.validateEmpresaID(id2);
        boolean result3 = ClienteProdutorEmpresa.validateEmpresaID(id3);
        boolean result4 = ClienteProdutorEmpresa.validateEmpresaID(id4);
        assertEquals(expResult, result);
        assertEquals(expResult2, result2);
        assertEquals(expResult3, result3);
        assertEquals(expResult4, result4);
    }

    @Test
    public void testValidateClienteID() {
        System.out.println("validateClienteID");
        String id = "123456789";
        String id2 = "C10";
        String id3 = "C10A";
        String id4 = "P10";
        boolean expResult = false;
        boolean expResult2 = true;
        boolean expResult3 = false;
        boolean expResult4 = false;
        boolean result = ClienteProdutorEmpresa.validateClienteID(id);
        boolean result2 = ClienteProdutorEmpresa.validateClienteID(id2);
        boolean result3 = ClienteProdutorEmpresa.validateClienteID(id3);
        boolean result4 = ClienteProdutorEmpresa.validateClienteID(id4);
        assertEquals(expResult, result);
        assertEquals(expResult2, result2);
        assertEquals(expResult3, result3);
        assertEquals(expResult4, result4);
    }

    @Test
    public void testValidateProdutorID() {
        System.out.println("validateProdutorID");
        String id = "123456789";
        String id2 = "P10";
        String id3 = "P10A";
        String id4 = "E10";
        boolean expResult = false;
        boolean expResult2 = true;
        boolean expResult3 = false;
        boolean expResult4 = false;
        boolean result = ClienteProdutorEmpresa.validateProdutorID(id);
        boolean result2 = ClienteProdutorEmpresa.validateProdutorID(id2);
        boolean result3 = ClienteProdutorEmpresa.validateProdutorID(id3);
        boolean result4 = ClienteProdutorEmpresa.validateProdutorID(id4);
        assertEquals(expResult, result);
        assertEquals(expResult2, result2);
        assertEquals(expResult3, result3);
        assertEquals(expResult4, result4);
    }
}
