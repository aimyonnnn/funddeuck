package com.itwillbs.test.handler;

import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ExceptionHandlerController {

	@ExceptionHandler(BadSqlGrammarException.class)
    public String handleBadSqlGrammarException(BadSqlGrammarException ex, Model model) {
        String msg = "해당 페이지는 접근이 불가능합니다.";
        model.addAttribute("msg", msg);
        return "fail_back";
    }
    
    @ExceptionHandler(Exception.class)
    public String handleException(Exception ex, Model model) {
        String msg = ex.getMessage();
        model.addAttribute("msg", msg);
        return "fail_back";
    }
	
}
