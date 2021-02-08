package com.example.demoo.Services;
import com.example.demoo.dto.CustomerDTO;
import java.util.List;

public interface CustomerService {

    void updateCustomer(CustomerDTO dto);

    void saveCustomer(CustomerDTO dto);

    CustomerDTO searchCustomer(String id);

    void deleteCustomer(String id);

    List<CustomerDTO> getAllCustomers();
}
