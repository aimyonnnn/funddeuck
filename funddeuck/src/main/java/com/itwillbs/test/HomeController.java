package com.itwillbs.test;

import java.text.DateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

    @Autowired
    private ProjectService ProjectService;


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model) {
        logger.info("Welcome home! The client locale is {}.", locale);

        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
        String formattedDate = dateFormat.format(date);
        model.addAttribute("serverTime", formattedDate);

        List<ProjectVO> projects = ProjectService.getAllProjects();

        model.addAttribute("projectList", projects);

        return "main";
    }

    @ResponseBody
    @GetMapping("/list")
    public List<ProjectVO> getProjectList() {
        return ProjectService.getTop10ProjectsByEndDate();
    }
    
    @ResponseBody
    @GetMapping("/randomProjects")
    public ResponseEntity<List<ProjectVO>> showRandomProjects() {
        List<ProjectVO> allProjects = ProjectService.getAllProjects();

        Collections.shuffle(allProjects);
        List<ProjectVO> randomProjects = allProjects.subList(0, Math.min(allProjects.size(), 6));

        return new ResponseEntity<>(randomProjects, HttpStatus.OK);
    }

    
}
