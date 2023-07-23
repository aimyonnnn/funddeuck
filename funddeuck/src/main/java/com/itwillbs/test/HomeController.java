package com.itwillbs.test;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.vo.ProjectVO;


@Controller
public class HomeController {

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    private final ProjectService ProjectService;

    @Autowired
    public HomeController(ProjectService ProjectService) {
        this.ProjectService = ProjectService;
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model) {
        logger.info("Welcome home! The client locale is {}.", locale);

        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
        String formattedDate = dateFormat.format(date);
        model.addAttribute("serverTime", formattedDate);

        List<ProjectVO> projects = ProjectService.getAllProjects();

        model.addAttribute("projects", projects);

        return "main";
    }

    @GetMapping("/list")
    public List<ProjectVO> getProjectList() {
        return ProjectService.getTop10ProjectsByEndDate();
    }
    
}
