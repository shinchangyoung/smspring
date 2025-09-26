package edu.sm.app.repository;

import edu.sm.app.dto.Admin;
import edu.sm.app.dto.Cate;
import edu.sm.common.frame.SmRepository;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface AdminRepository extends SmRepository<Admin, String> {
    @Override
    @Insert("INSERT INTO admin (admin_id) VALUES (#{adminId},#{admPwd},#{admRole})")
    void insert(Admin admin) throws Exception;

    @Override
    @Update("UPDATE admin SET admin_id=#{adminId},admin_pwd=#{adminPwd},admin_role=#{adminRole} WHERE admin_id=#{adminId}")
    void update(Admin admin) throws Exception;

    @Override
    @Delete("DELETE FROM admin WHERE admin_id=#{adminId}")
    void delete(String string) throws Exception;

    @Override
    @Select("SELECT * FROM admin")
    List<Admin> selectAll() throws Exception;

    @Override
    @Select("SELECT * FROM admin WHERE admin_id=#{adminId}")
    Admin select(String string) throws Exception;
}