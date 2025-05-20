package com.javaweb.service.news;

import com.javaweb.constant.SystemConstant;
import com.javaweb.converter.NewsConverter;
import com.javaweb.entity.NewsEntity;
import com.javaweb.model.dto.NewsDTO;
import com.javaweb.model.request.NewsSearchRequest;
import com.javaweb.model.response.NewsSearchResponse;
import com.javaweb.repository.NewsRepository;
import com.javaweb.util.UploadFileUtils;
import lombok.RequiredArgsConstructor;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import java.io.File;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class NewsService implements INewsService{
    private final NewsRepository newsRepository;
    private final NewsConverter newsConverter;
    private final UploadFileUtils uploadFileUtils;

    @Override
    public List<NewsSearchResponse> findAll(NewsSearchRequest newsSearchRequest, Pageable pageable) {
        List<NewsEntity> newsEntityList = newsRepository.findAll(newsSearchRequest, pageable);

        return newsEntityList.stream().map(newsConverter::convertToSearchResponse).collect(Collectors.toList());
    }

    @Override
    public Page<NewsSearchResponse> findAll_Web(NewsSearchRequest newsSearchRequest, Pageable pageable) {
        Page<NewsEntity> newsEntityList = newsRepository.findAll_Web(newsSearchRequest, pageable);

        return newsEntityList.map(newsConverter::convertToSearchResponse);
    }

    @Override
    public NewsDTO findOneById(Long id) {
        return newsConverter.convertToDTO(newsRepository.getOne(id));
    }

    // Each time you read a new, increase it's view number
    @Override
    public NewsDTO findOneByIdToView(Long id) {
        NewsEntity newsEntity = newsRepository.getOne(id);

        if(!ObjectUtils.isEmpty(newsEntity)){
            newsEntity.setView(newsEntity.getView() + 1L);

            return newsConverter.convertToDTO(newsRepository.save(newsEntity));
        }

        return null;
    }

    @Override
    public List<NewsSearchResponse> findMostPopularNews_Web() {
        List<NewsEntity> newsEntities = newsRepository.findHotWithLimit();

        return newsEntities.stream().map(newsConverter::convertToSearchResponse).collect(Collectors.toList());
    }

    @Override
    public void editNews(NewsDTO newsDTO) {
        NewsEntity existedEntity = new NewsEntity();

        if(newsDTO.getId() != null){
            existedEntity = newsRepository.getOne(newsDTO.getId());
        }

        NewsEntity entityEditing = newsConverter.convertToEntity(newsDTO, existedEntity);

        saveImages(newsDTO, entityEditing);

        newsRepository.save(entityEditing);
    }

    @Override
    public void deleteAllNewsSelected(List<Long> ids) {
        try{
            List<NewsEntity> newsEntities = newsRepository.findAllById(ids);

            newsEntities.forEach(newsEntity -> {
                newsEntity.setIsActive(0);
            });

            newsRepository.saveAll(newsEntities);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public Long countTotalViews() {
        return newsRepository.countAllViews();
    }

    @Override
    public int countTotalItems(NewsSearchRequest newsSearchRequest) {
        return newsRepository.countTotalItems(newsSearchRequest);
    }

    // Save images
    private void saveImages(NewsDTO newsDTO, NewsEntity newsEntity) {
        String path = "/news/" + newsDTO.getImageName();

        if ( newsDTO.getImageBase64() != null ) {
            if ( newsEntity.getImage() != null ) {
                if (!path.equals(newsEntity.getImage())) {
                    File file = new File(SystemConstant.IMAGE_SAVE_PATH + newsEntity.getImage());
                    file.delete();
                }
            }

            byte[] bytes = Base64.decodeBase64(newsDTO.getImageBase64().getBytes());

            uploadFileUtils.writeOrUpdate(path, bytes);
            newsEntity.setImage(path);
        }
    }
}
